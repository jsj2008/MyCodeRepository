var ClientPC = function()
{
    var L_this = this;
    this._mars_k = new MarsK(
        'tc01', // HTML Element ID.
        'H1', // Time type.
        'src/i18n/', // Locale URL root.
        function( IN_msg) // Message callback.
        {
            var L_type = IN_msg['type'];
            var L_value = IN_msg['value'];
            switch (L_type) 
            {
                case 'removed':
                    break;

                case 'configure':
                    var L_area_xy = L_value['area_xy'];
                    L_this.displayConfigDialogForAreaXY( L_area_xy);
                    break;
            }
        }
    );
    
    this._mars_k.insertDummyTicks();
    this._mars_k.paint();

    //MarsKUtility.prototype.registerEvent( window, 'resize', this._mars_k, function(){ this.resizeToClientSize(); });
    //this._testLastTickUpdating();
};

ClientPC.prototype.initLayout = function()
{
    var L_this = this;
    var L_layout = $( 'body').layout(
        {
            'north':
            {
                'resizable': false,
                'closable':  false,
            },
            'west':
            {
                'resizable': false,
                'closable':  false,
            },
            'center':
            {
                'resizable': false,
                'closable':  false,
                'onresize': function()
                {
                    L_this._mars_k.resizeToClientSize();
                }
            },
            'east':
            {
                'resizable': false,
                'closable':  false,
            },
            'south':
            {
                'resizable': false,
                'closable':  false,
            },
        }
    );
        
    var L_pane_size = '0px';
    L_layout.sizePane( 'north', L_pane_size);
    L_layout.sizePane( 'west', L_pane_size);
    L_layout.sizePane( 'east', L_pane_size);
    L_layout.sizePane( 'south', L_pane_size);
    
    $( '#btn_add_tech').click(
        function()
        {
            var L_tech_type = $( '#sel_techs').val();
            var L_tech_area_id = L_this._mars_k.addTechArea( L_tech_type);
        }
    );
        
    $( '#btn_tick_style_candle').click(
        function()
        {
            L_this._mars_k.setTickStyleToCandle();
        }
    );
        
    $( '#btn_tick_style_bar').click(
        function()
        {
            L_this._mars_k.setTickStyleToBar();
        }
    );

    $( '#btn_tick_style_line').click(
        function()
        {
            L_this._mars_k.setTickStyleToLine();
        }
    );

    $( '.ui-dialog').dialog(
        {
            'modal': true,
            'dialogClass': '',
            'closeOnEscape': true,
            'autoResize': false,
            'autoOpen': false,
            'draggable': true,
            'resizable': false,
            'width': 'auto',
            'height': 'auto',
            'close': function( IN_event, IN_ui)
            {
                $( '#fullscreen_mask').hide();
            },
            'open': function( IN_event, IN_ui)
            {
                //L_this._client_utility.centerAlignDialogForAllBrowser( $( this));
                $( this).find( '[tabindex=0]:first').focus();
                $( this).css( 'overflow', 'hidden');
            }
        }
    );
    
    try {
        this._mars_k.setLocale(
            'zh-TW',
            function( IN_locale, IN_is_succeeded)
            {
                // Init technical indices.
                var L_html_of_selection = '';
                var L_available_techs = this.getAvailableTechs();
                for (var L_tech_type in L_available_techs) {
                    var L_the_tech = L_available_techs[L_tech_type];
                    var L_tech_name = this.i18n( L_the_tech['name_i18n']);
                    L_html_of_selection += '<option value="' + L_tech_type + '">' + L_tech_name + '</option>';
                }

                $( '#sel_techs').html( L_html_of_selection);
            }
        );
    }
    catch (err) {
        this._mars_k._i18n_lang = MarsKI18N;

        // Init technical indices.
        var L_html_of_selection = '';
        var L_available_techs = this._mars_k.getAvailableTechs();
        for (var L_tech_type in L_available_techs) {
            var L_the_tech = L_available_techs[L_tech_type];
            var L_tech_name = this._mars_k.i18n( L_the_tech['name_i18n']);
            L_html_of_selection += '<option value="' + L_tech_type + '">' + L_tech_name + '</option>';
        }

        $( '#sel_techs').html( L_html_of_selection);

        console.error( err);
    }
    
    this._mars_k.resizeToClientSize();    
};

ClientPC.prototype.displayConfigDialogForAreaXY = function( IN_area_xy)
{
    var L_jquery_dialog = $( '#dlg_tech_index_config');
    var L_definitions = IN_area_xy.getDefinition();
    var L_definitions_of_params = L_definitions['params'];
    var L_params = IN_area_xy.getParams();
    
    // Remove children.
    L_jquery_dialog.empty();
    L_jquery_dialog.data( 'area_xy', IN_area_xy);
    L_jquery_dialog.dialog( 'option', 'title', this._mars_k.i18n( L_definitions['name_i18n']));
    
    // Generate config UI for area tech.
    var L_jquery_table = $( '<table></table>').appendTo( L_jquery_dialog);

    for (var L_param_name in L_definitions_of_params) {
        var L_definitions_of_param = L_definitions_of_params[L_param_name];
        var L_default_value = L_definitions_of_param[0];
        var L_declaration = L_definitions_of_param[1];
        var L_param_alias_i18n = L_declaration['alias_i18n'];
        var L_param_alias = this._mars_k.i18n( L_param_alias_i18n);
        var L_param_name_display_name = L_param_alias ? L_param_alias : L_param_name;
        var L_param_value = L_params[L_param_name];
        
        // Build columns.
        var L_jquery_row = $( '<tr></tr>').appendTo( L_jquery_table);
        var L_jquery_column_of_display_name = $( '<td></td>').appendTo( L_jquery_row);
        var L_jquery_column_of_value = $( '<td></td>').appendTo( L_jquery_row);
        
        // Setup columns.
        L_jquery_column_of_display_name.text( L_param_name_display_name);
        
        // Determine value column by type.
        var L_jquery_value;
        switch (L_declaration['type'])
        {
            case AreaXY.prototype.PARAM_TYPES['NUMBER']:
                L_jquery_value = $( '<input />').appendTo( L_jquery_column_of_value);
                L_jquery_value.val( L_param_value);                
                L_jquery_value.spinner(
                    {
                        'min': L_declaration['min'],
                        'max': L_declaration['max']
                    }
                );
                    
                L_jquery_value.data(
                    'reset',
                    function( IN_default_value) {
                        return function( IN_self)
                        {
                            IN_self.val( IN_default_value);
                        };
                    }( L_default_value)
                );
                break;

            case AreaXY.prototype.PARAM_TYPES['ENUM']:
                L_jquery_value = $( '<select></select>').appendTo( L_jquery_column_of_value);
                
                var L_html = '';
                var L_value_enum = L_declaration['enum'];
                for (var i in L_value_enum) {
                    L_html += '<option value="' + L_value_enum[i] + '">' + L_value_enum[i] + '</option>';
                }
                
                L_jquery_value.html( L_html);
                L_jquery_value.val( L_param_value);                
                
                L_jquery_value.data(
                    'reset',
                    function( IN_default_value) {
                        return function( IN_self)
                        {
                            IN_self.val( IN_default_value);
                        };
                    }( L_default_value)
                );
                break;

            case AreaXY.prototype.PARAM_TYPES['COLOR']:
                var L_jquery_value = $( '<input />').appendTo( L_jquery_column_of_value);
                var L_color_arr = MarsKUtility.prototype.colorStringToArray( L_param_value);
                var L_has_alpha = L_color_arr.length >= 4;
                var L_color_hex = MarsKUtility.prototype.rgbArrayToHexStr( L_color_arr);
                L_jquery_value.minicolors(
                    {
                        'control': 'hue',
                        'defaultValue': L_color_hex,
                        'inline': false,
                        'letterCase': 'lowercase',
                        'opacity': L_has_alpha,
                        'position': 'bottom left',
                        'theme': 'default',
                    }
                );
                
                if (L_has_alpha) {
                    L_jquery_value.minicolors( 'opacity', L_color_arr[3]);
                }
                    
                L_jquery_value.addClass( 'ui-widget-content');
                L_jquery_value.data(
                    'reset',
                    function( IN_default_value) {
                        var L_color_arr = MarsKUtility.prototype.colorStringToArray( IN_default_value);
                        var L_color_hex = MarsKUtility.prototype.rgbArrayToHexStr( L_color_arr);

                        return function( IN_self)
                        {
                            IN_self.minicolors( 'value', L_color_hex);
                            
                            if (L_color_arr.length >= 4) {
                                // Has alpha.
                                IN_self.minicolors( 'opacity', L_color_arr[3]);
                            }
                        };
                    }( L_default_value)
                );
                break;
                
            default:
                debugger;
                return;
        }
        
        // Setup some data for value column.
        L_jquery_value.data( 'param_type', L_declaration['type']);
        L_jquery_value.data( 'param_name', L_param_name);
        L_jquery_value.addClass( 'mars_k_area_value');
        L_jquery_value.prop( 'tabindex', -1);
    }
    
    $( '<br/><hr/>').appendTo( L_jquery_dialog);
    var L_jquery_left_div = $( '<div style="float: left;"></div>').appendTo( L_jquery_dialog);
    var L_jquery_right_div = $( '<div style="float: right;"></div>').appendTo( L_jquery_dialog);
    var L_jquery_reset_button = $( '<input type="button" value="Reset" />').appendTo( L_jquery_left_div).button();
    var L_jquery_ok_button = $( '<input type="button" value="OK" />').appendTo( L_jquery_right_div).button();
    var L_jquery_cancel_button = $( '<input type="button" value="Cancel" tabindex=0 />').appendTo( L_jquery_right_div).button();
    
    // Bind events.
    var L_this = this;
    L_jquery_ok_button.on(
        'click',
        function()
        {
            var L_area_xy = L_jquery_dialog.data( 'area_xy');
            
            L_jquery_table.find( '.mars_k_area_value').each(
                function()
                {
                    var L_self = $( this);
                    var L_param_type = L_self.data( 'param_type');
                    var L_param_name = L_self.data( 'param_name');
                    var L_value;
                    
                    switch (L_param_type)
                    {
                        case AreaXY.prototype.PARAM_TYPES['NUMBER']:
                            L_value = L_self.val();
                            break;
                            
                        case AreaXY.prototype.PARAM_TYPES['ENUM']:
                            L_value = L_self.val();
                            break;
                            
                        case AreaXY.prototype.PARAM_TYPES['COLOR']:
                            L_value = L_self.minicolors( 'rgbaString');
                            break;
                    }
                    
                    console.log( 'Set param "' + L_param_name + '" to ' + L_value);
                    L_area_xy.setParam( L_param_name, L_value);
                }
            );

            if (L_area_xy.doEvaluateAll) {
                L_area_xy.doEvaluateAll();
            }
            
            L_this._mars_k.evalAllKTicksPaintingPriceHighLow();
            L_this._mars_k.cleanPaintCache();
            L_this._mars_k.paint();
            
            L_jquery_dialog.dialog( 'close');
        }
    );
    
    L_jquery_cancel_button.on(
        'click',
        function()
        {
            L_jquery_dialog.dialog( 'close');
        }
    )
    
    L_jquery_reset_button.on(
        'click',
        function()
        {
            L_jquery_table.find( '*').each(
                function()
                {
                    var L_self = $( this);
                    var L_reset = L_self.data( 'reset');
                    if (L_reset != null) {
                        L_reset( L_self);
                    }
                }
            );
        }
    );

    L_jquery_dialog.dialog( 'open');
};


ClientPC.prototype._testLastTickUpdating =

    function() {
        var L_this = this;
        var L_func_update_last_tick = function() {
            var tick = L_this._mars_k._all_ticks[L_this._mars_k._all_ticks.length -1];
            var price = tick.close * (9990+Math.random()*20)/10000;
            tick.high = price>tick.high? price : tick.high;
            tick.low = price<tick.low? price : tick.low;
            tick.close = price;
            L_this._mars_k.updateLastTick( tick );
            setTimeout( L_func_update_last_tick, 1000 );
        };
        setTimeout( L_func_update_last_tick, 1000 );
    };