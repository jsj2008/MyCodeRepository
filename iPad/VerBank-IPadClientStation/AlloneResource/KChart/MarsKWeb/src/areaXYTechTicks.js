var AreaTechTicks = function()
{
};

AreaTechTicks.prototype = new AreaXYTech();

AreaTechTicks.prototype._initAreaTechTicks = function( IN_mars_k, IN_tech_type, IN_tech_area_id)
{
    this._initAreaTech( IN_mars_k, IN_tech_type, IN_tech_area_id);
};
