package server.services.store;

import mtasa.server.classes.Player;
import server.services.store.classes.Store;

class StoreService {
	public static var stores: Array<Store> = [];

	public static function getPlayerStore(player: Player): Null<Store> {
		return stores.filter(store -> isElementWithinMarker(player, store.getMarker())).pop();
	}
}
