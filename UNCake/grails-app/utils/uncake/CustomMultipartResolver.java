package uncake;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;

public class CustomMultipartResolver extends CommonsMultipartResolver {

    static final String FILE_SIZE_EXCEEDED_ERROR = "fileSizeExceeded";

    public MultipartHttpServletRequest resolveMultipart(HttpServletRequest request) {

        try {
            return super.resolveMultipart(request);
        } catch (MaxUploadSizeExceededException e) {
            request.setAttribute(FILE_SIZE_EXCEEDED_ERROR, true);
            return new DefaultMultipartHttpServletRequest(request, new LinkedMultiValueMap<>(), new LinkedHashMap<>(), new LinkedHashMap<>());
        }
    }
}