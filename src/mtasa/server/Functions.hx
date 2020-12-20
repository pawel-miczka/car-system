package mtasa.server;

import mtasa.server.classes.Marker;
import mtasa.client.classes.Element;
import mtasa.server.classes.Player;
import mtasa.shared.classes.Vector3;
import mtasa.server.classes.Vehicle;
import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;
import mtasa.server.classes.DatabaseConnection;
import mtasa.server.classes.DatabaseQueryHandle;

@:native('_G')
extern class Functions {
	public static function dbConnect(databaseType: String, host: String, ?username: String, ?password: String, ?options: String): DatabaseConnection;

	public static function dbExec(connection: DatabaseConnection, query: String, params: Rest<EitherType<String, Int>>): Bool;

	public static function dbQuery(callbackFunction: (DatabaseQueryHandle) -> Void, ?callbackArguments: Array<Dynamic>, connection: DatabaseConnection,
		query: String, params: Rest<EitherType<String, Int>>): DatabaseQueryHandle;

	public static function dbPoll(handle: DatabaseQueryHandle, timeout: Int, ?multipleResults: Bool = false): lua.Table<Int, Dynamic>;

	public static function fromJSON(json: String): Dynamic;

	public static function toJSON(value: Dynamic, ?compact: Bool = false, ?prettyType: String = "none"): String;

	public static function createVehicle(model: Int, position: Vector3, ?rotation: Vector3, ?numberplate: String, ?variant1: Int, ?variant2: Int): Vehicle;

	public static function fadeCamera(player: Player, fadeIn: Bool): Bool;

	public static function getElementsByType(type: String): lua.Table<Int, Dynamic>;

	static function addEventHandler(eventName: String, attachedTo: Element, handlerFunction: Function, ?propagate: Bool = true,
		?priority: String = "normal"): Bool;

	static function spawnPlayer(player: Player, position: Vector3, ?rotation: Int = 0): Bool;

	static function setCameraTarget(player: Player, ?target: Player = null): Bool;

	static function addCommandHandler(commandName: String, handler: Function, ?restricted: Bool, ?caseSensitive: Bool): Bool;

	static function createMarker(position: Vector3, ?type: String = 'checkpoint', ?size: Float = 4.0): Marker;

	static function isElementWithinMarker(element: Element, marker: Marker): Bool;

	static function outputChatBox(text: String): Bool;
}
