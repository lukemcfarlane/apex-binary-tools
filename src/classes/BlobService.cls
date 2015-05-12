public with sharing class BlobService {
    private static final List<String> base64ValArr = new List<String> {
         'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };


    public static ByteArray getByteArray(Blob b) {
        String bitStr = getBitStr(EncodingUtil.base64Encode(b));
        return new ByteArray(bitStr);
    }

    public static String getBase64Str(ByteArray byteArr) {
        String b64Str = '';

        Double b64SizeDbl = (byteArr.getSize() / 3);
        Integer numPaddings = Math.mod(byteArr.getSize(), 3);
        Integer b64Size = Math.ceil(b64SizeDbl).intValue() * 4;
        for(Integer i = 0; i < b64Size; i++) {
            String bits = byteArr.bitstring.substring(6 * i, (6 * i) + 6);
            Integer index = BinaryService.getInteger(bits);
            b64Str += base64ValArr[index];
        }

        String paddingChar = '=';
        b64Str += paddingChar.repeat(numPaddings);
        return b64Str;
    }

    public static String getBitStr(String b64) {
        Map<String, Integer> base64IndexMap = new Map<String, Integer>();
        for(Integer i = 0; i < base64ValArr.size(); i++) {
            base64IndexMap.put(base64ValArr[i], i);
        }

        List<String> b64ValArr = b64.split('');
        b64ValArr.remove(0); // first element will be blank


        Integer numPaddings = 0;
        List<String> bitPatternArr = new List<String>();
        for(String b64Val : b64ValArr) {
            System.debug('## b64Val: ' + b64Val);
            if(b64Val == '=') {
                bitPatternArr.add('000000');
                numPaddings++;
            } else {
                Integer index = base64IndexMap.get(b64Val);
                System.debug('## Adding index: ' + index);
                System.debug('## Adding: ' + BinaryService.getBitstring(index));
                bitPatternArr.add(BinaryService.getBitstring(index).leftPad(6).replace(' ', '0'));
            }
        }

        Integer numOutputBytes = 3 * (b64ValArr.size() / 4) - numPaddings;
        System.debug('## num output bytes: ' + numOutputBytes);
        System.debug('## bitBatterArr ' + bitPatternArr);

        String bitstringsJoined = String.join(bitPatternArr, '');

        String fullBitstring = bitstringsJoined.left(8 * numOutputBytes);

        return fullBitstring;    
    }


}