package server.services.store.classes;

import mtasa.server.classes.Marker;
import server.enums.VehicleModel;
import mtasa.shared.classes.Vector3;

class Store {
	private var position: Vector3 = null;
	private var prices: Map<VehicleModel, Int> = [];
	private var marker: Marker = null;

	public function new(position: Vector3, prices: Map<VehicleModel, Int>) {
		this.position = position;
		this.prices = prices;

		this.createEntrance();

		StoreService.stores.push(this);
	}

	public function createEntrance() {
		this.marker = createMarker(this.position, 'cylinder');
	}

	public function getMarker(): Marker {
		return this.marker;
	}

	public function getPrices(): Map<VehicleModel, Int> {
		return this.prices;
	}
}
