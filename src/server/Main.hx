package server;

import haxe.Exception;
import server.services.store.classes.Store;
import server.services.store.StoreService;
import haxe.Json;
import lua.Table;
import mtasa.server.classes.DatabaseConnection;
import mtasa.server.classes.DatabaseQueryHandle;
import mtasa.server.classes.Player;
import mtasa.shared.classes.Vector3;

using lua.PairTools;

typedef VehicleModel = {
	var id: Int;
	var position: String;
	var rotation: String;
}

class Main {
	static var connection: Null<DatabaseConnection> = null;

	static function main() {
		addEventHandler('onResourceStart', root, () -> {
			connection = dbConnect("sqlite", "./static/database.db");

			dbExec(connection, "
				CREATE TABLE IF NOT EXISTS vehicles (
				model INTEGER NOT NULL,
				position TEXT NOT NULL,
				rotation TEXT NOT NULL
			)");

			loadAllVehicles();
			spawnAllPlayersAtCenterOfMap();
			createStores();

			addCommandHandler('buyveh', (player: Player, command: String, model: Null<String>) -> {
				try {
					if (model == null)
						throw new Exception('Musisz podać model');

					var modelNumber = Std.parseInt(model);
					var store = StoreService.getPlayerStore(player);

					if (store == null)
						throw new Exception('Musisz być w sklepie');

					var modelPrice = store.getPrices().get(cast(modelNumber, server.enums.VehicleModel));

					if (modelPrice == null)
						throw new Exception('Brak ceny dla tego modelu');

					trace(modelPrice);
				} catch (e) {
					outputChatBox(e.message);
				}
				// var model = 567;
				// var position = '{"x": ${player.position.x}, "y": ${player.position.y}, "z": ${player.position.z}}';
				// var rotation = '{"x": ${player.rotation.x}, "y": ${player.rotation.y}, "z": ${player.rotation.z}}';

				// dbExec(connection, 'INSERT INTO vehicles (model, position, rotation) VALUES ($model, \'$position\', \'$rotation\')');
				// createVehicle(567, player.position, player.rotation);
			});

			addCommandHandler('getpos', (player: Player) -> {
				trace(player.position);
			});
		});
	}

	public static function spawnAllPlayersAtCenterOfMap() {
		getElementsByType('player').ipairsEach((i, player: Player) -> {
			fadeCamera(player, true);
			setCameraTarget(player, player);
			spawnPlayer(player, Vector3.create(545.917, -1274.280, 17.248));
		});
	}

	public static function loadAllVehicles() {
		dbQuery(qh -> {
			dbPoll(qh, -1).ipairsEach((i, result: VehicleModel) -> {
				var position = Vector3.create(fromJSON(result.position));
				var rotation = Vector3.create(fromJSON(result.rotation));

				createVehicle(567, position, rotation);
			});
		}, [], connection, 'SELECT * FROM vehicles;');
	}

	public static function createStores() {
		new Store(Vector3.create(547.003, -1290.831, 16.248), [savanna => 10000, landstalker => 5000]);
	}
}
