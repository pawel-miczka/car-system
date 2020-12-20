package mtasa.client.enums;

abstract DxTestMode(String) from String to String {
	public static inline var NONE: String = 'none';
	public static inline var NO_MEM: String = 'no_mem';
	public static inline var LOW_MEM: String = 'low_mem';
	public static inline var NO_SHADER: String = 'no_shader';
}
