public with sharing class Byte2 {
    public String bitStr    { get; set; }

	private Byte2(String bitStr) {
		this.bitStr = bitStr;
	}

    private Byte2(Integer i) {
        this.bitStr = BinaryService.getBitstring(i);
    }

    public Integer getUInt() {
        System.debug('## Getting integer for bitstring: ' + this.bitStr);
        return BinaryService.getInteger(this.bitStr);
    }

    public static Byte2 fromUInt(Integer i) {
        return new Byte2(i);
    }

    public static Byte2 fromBitStr(String s) {
        return new Byte2(s);
    }
}