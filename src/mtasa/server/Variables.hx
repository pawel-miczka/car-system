package mtasa.server;

import mtasa.client.classes.Element;

typedef RootElement = Element;

@:native('_G')
extern class Variables {
	static var root: RootElement;
}
