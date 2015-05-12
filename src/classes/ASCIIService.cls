public with sharing class ASCIIService {
    private static final List<String> asciiValArr = new List<String> {
         '(nul)', '(soh)', '(stx)', '(etx)', '(eot)', '(enq)', '(ack)', '(bel)', '(bs)', '(ht)', '(nl)', '(vt)', '(np)', '(cr)', '(so)', '(si)', '(dle)', '(dc1)', '(dc2)', '(dc3)', '(dc4)', '(nak)', '(syn)', '(etb)', '(can)', '(em)', '(sub)', '(esc)', '(fs)', '(gs)', '(rs)', '(us)', '(sp)', '!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', '\\', ']', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}', '~', '(del)'
    };

    public static String getString(List<Integer> uintArr) {
        String s = '';
        for(Integer i : uintArr) {
            s += asciiValArr[i];
        }
        return s;
    }

    public static List<Integer> getIndexArr(String s) {
        Map<String, Integer> asciiIndexMap = new Map<String, Integer>();
        for(Integer i = 0; i < asciiValArr.size(); i++) {
            asciiIndexMap.put(asciiValArr[i], i);
        }

        List<String> chars = s.split('');
        chars.remove(0); // first element will be empty
        List<Integer> indexArr = new List<Integer>();
        for(String c : chars) {
            Integer index = asciiIndexMap.get(c);
            indexArr.add(index);
        }

        return indexArr;
    }
}