package jedi.ex01.client.station.api.doc;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

public class DocMapList<K, V> {

	private HashMap<K, V> map = new HashMap<K, V>();
	private ArrayList<V> list = new ArrayList<V>();

	public List<V> getList() {
		synchronized (map) {
			return Collections.unmodifiableList(list);
		}
	}

	public V getValue(K k) {
		synchronized (map) {
			return map.get(k);
		}
	}

	public boolean contains(K k) {
		synchronized (map) {
			return map.containsKey(k);
		}
	}

	public void put(K k, V v) {
		synchronized (map) {
			remove(k);
			map.put(k, v);
			list.add(v);
		}
	}

	public V remove(K k) {
		synchronized (map) {
			if (!map.containsKey(k)) {
				return null;
			} else {
				V v = map.remove(k);
				for (int i = 0; i < list.size(); i++) {
					V tempv = list.get(i);
					if (tempv == v) {
						list.remove(i);
						break;
					}
				}
				return v;
			}
		}
	}

	public void clear() {
		synchronized (map) {
			map.clear();
			list.clear();
		}
	}
 
}
