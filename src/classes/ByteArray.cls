public with sharing class ByteArray {
    public class ByteArrayException extends Exception {}

    private List<Byte2> byteArr;
    public  String      bitstring { get; private set; }

	public ByteArray() {
		this.byteArr = new List<Byte2>();
	}

    public ByteArray(List<ByteArray> byteArrays) {
        this.byteArr = new List<Byte2>();
        for(ByteArray ba : byteArrays) {
            this.byteArr.addAll(ba.getBytes());
        }
    }

    public ByteArray(List<Byte2> bytes) {
        this.byteArr = bytes;
    }

    public ByteArray(String bitstring) {
        if(Math.mod(bitstring.length(), 8) != 0) {
            throw new ByteArrayException('Bitstring length must be divisible by 8');
        }

        this.bitstring = bitstring;
        this.byteArr = new List<Byte2>();
        Double numBytesDbl = bitstring.length() / 8;
        Integer numBytes = numBytesDbl.intValue();

        for(Integer i = 0; i < numBytes; i++) {
            String byteAsStr = bitstring.substring(i * 8, (i * 8) + 8);
            System.debug('## Adding byte to array: ' + byteAsStr);
            this.byteArr.add(
                Byte2.fromBitStr(byteAsStr)
            );
        }
    }

    public void addByte(Byte2 b) {
        this.byteArr.add(b);
        this.bitstring += b.bitStr;
    }

    public Byte2 getByte(Integer offset) {
        return this.byteArr[offset];
    }

    public ByteArray getBytes(List<Integer> byteIndices) {
        ByteArray newByteArr = new ByteArray();
        for(Integer i : byteIndices) {
            newByteArr.addByte(getByte(i));
        }
        return newByteArr;
    }

    public ByteArray getBytes(Integer offset, Integer numBytes) {
        ByteArray newByteArr = new ByteArray();
        for(Integer i = offset; i <= offset + numBytes; i++) {
            newByteArr.addByte(getByte(i));
        }
        return newByteArr;
    }

    public List<Byte2> getBytes() {
        return this.byteArr;
    }

    public List<Integer> getUIntArr() {
        List<Integer> uIntArr = new List<Integer>();
        for(Byte2 b : this.byteArr) {
            uIntArr.add(b.getUInt());
        }
        return uIntArr;
    }

    public String getString() {
        String s = '';
        for(Byte2 b : this.byteArr) {
            s += String.fromCharArray(new List<Integer> { b.getUInt() });
        }
        return s;
    }

    public Integer getIntegerLSBFirst() {
        String bits = '';
        for(Integer i = this.byteArr.size() - 1; i >= 0; i--) {
            bits += this.byteArr[i].bitStr;
        }

        return BinaryService.getInteger(bits);
    }

    public Integer getSize() {
        return this.byteArr.size();
    }

    public Blob getBlob() {
        return null;
    }

}