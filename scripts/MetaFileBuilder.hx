import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;

using StringTools;
using haxe.xml.Printer;

typedef LuaSourceFile = {
	path: String,
	type: String
}

class MetaFileBuilder {
	static var OUTPUT_DIR = './dist';

	static function main() {
		// encodeLuaFiles();
		generateMetaFile();
	}

	static function generateMetaFile() {
		File.saveContent('meta.xml', getXMLSchema().print());
	}

	static function encodeLuaFiles() {
		for (file in getLuaFilesFromDist()) {
			var command = Sys.systemName() == 'Windows' ? '.\\encoders\\mtasa_encoder.exe' : './encoders/mtasa_encoder';
			Sys.command('${command} -e3 -o ${file.path} ${file.path}');
		}
	}

	static function getXMLSchema(): Xml {
		var root = Xml.createElement('meta');

		var oop = Xml.createElement('oop');
		oop.addChild(Xml.createPCData("true"));
		root.addChild(oop);

		for (file in getLuaFilesFromDist()) {
			var child = Xml.createElement('script');
			child.set('src', file.path);
			child.set('type', file.type);
			root.addChild(child);
		};

		return root;
	}

	static function getLuaFilesFromDist(): Array<LuaSourceFile> {
		var files: Array<LuaSourceFile> = [];

		function recursiveLoop(directory: String) {
			for (file in FileSystem.readDirectory(directory)) {
				var path = Path.join([directory, file]);
				if (!FileSystem.isDirectory(path)) {
					if (!path.contains('.lua'))
						continue;
					var type = path.contains('client') ? 'client' : 'server';
					files.push({path: path, type: type});
				} else {
					var directory = Path.addTrailingSlash(path);
					recursiveLoop(directory);
				}
			}
		}

		recursiveLoop(OUTPUT_DIR);

		return files;
	}
}
