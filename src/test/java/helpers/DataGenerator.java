package helpers;
import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;


public class DataGenerator {
    

    public static JSONObject getRandomIssueValues(){
        
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
   
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        return json;
    }
}

