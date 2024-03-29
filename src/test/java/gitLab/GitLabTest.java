package gitLab;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class GitLabTest {

    @Test
    void testParallel() {

        // Write the path of the project file
        
        Results results = Runner.path("classpath:gitLab")
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
