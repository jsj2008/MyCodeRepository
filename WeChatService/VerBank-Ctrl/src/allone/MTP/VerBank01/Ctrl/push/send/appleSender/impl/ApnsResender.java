/*
 * Copyright 2013 DiscoveryBay Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package allone.MTP.VerBank01.Ctrl.push.send.appleSender.impl;

import java.util.Queue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import allone.MTP.VerBank01.Ctrl.push.send.appleSender.IApnsService;
import allone.MTP.VerBank01.Ctrl.push.send.appleSender.model.PushNotification;

public class ApnsResender {
	private static Log logger = LogFactory.getLog(ApnsResender.class);
	private static ApnsResender instance = new ApnsResender();

	public static ApnsResender getInstance() {
		return instance;
	}

	public void resend(String name, Queue<PushNotification> queue) {
		IApnsService service = ApnsServiceImpl.getCachedService(name);
		if (service != null) {
			while (!queue.isEmpty()) {
				service.sendNotification(queue.poll());
			}
		} else {
			logger.error("Cached service is null. name: " + name);
		}
	}

}
