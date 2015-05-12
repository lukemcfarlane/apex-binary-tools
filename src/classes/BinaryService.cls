public with sharing class BinaryService {
    public class BinaryServiceException extends Exception {}

    public static Integer getInteger(String bitStr) {
        List<Boolean> bits = getBits(bitStr.reverse());

        Integer intVal = 0;
        Integer weight = 0;
        for(Integer i = 0; i < bits.size(); i++) {
            weight = Math.pow(Double.valueOf(2), Double.valueOf(i)).intValue();
            if(bits[i]) { 
                intVal += weight;
            }
        }

        return intVal;
    }

    public static String getBitstring(Integer i) {
        List<Boolean> bitsArrReversed = new List<Boolean>();

        Integer quotient = i;
        while(quotient > 0) {
            Integer remainder = Math.mod(quotient, 2);
            Boolean bitVal = remainder == 0 ? false : true;
            bitsArrReversed.add(bitVal);
            Double divRes = quotient / 2;
            quotient = divRes.intValue();
        }
        return getBitstring(bitsArrReversed).reverse();
    }

    public static String getBitstring(List<Boolean> bitsArr) {
        String s = '';
        for(Boolean b : bitsArr) {
            if(b) s += '1';
            else s += '0';
        }
        return s;
    }

    public static List<Boolean> getBits(String bitStr) {
        List<String> chars = bitStr.split('');
        chars.remove(0); // first element will be empty

        List<Boolean> bitsArr = new List<Boolean>();
        for(String c : chars) {
            if(c == '0') bitsArr.add(false);
            else if(c == '1') bitsArr.add(true);
            else {
                throw new BinaryServiceException('Bitstring must only consist of characters \'1\' and \'0\', found \'' + c + '\': \'' + bitStr + '\'');
            }
        }
        return bitsArr;
    }
}