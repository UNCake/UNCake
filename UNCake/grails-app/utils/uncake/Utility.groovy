package uncake
import java.text.Normalizer

/**
 * Created by anmrdz on 10/24/15.
 */

class Utility{

    static String stripAccents(text){
        return Normalizer.normalize(text, Normalizer.Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", '')
    }
}
