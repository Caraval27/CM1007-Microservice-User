package journal.backend_user.Core;

import journal.backend_user.Core.Model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:8081",
        "http://journal-app-frontend.app.cloud.cbh.kth.se", "https://journal-app-message.app.cloud.cbh.kth.se:8081"})
@RestController
public class Controller {
    @Autowired
    private UserService userService;

    public Controller() {
    }

    @PostMapping("/sign_up")
    public ResponseEntity<Void> createUser(@RequestBody User user) {
        try {
            userService.createUser(user);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/find_user")
    public ResponseEntity<Boolean> userExists(@RequestParam String id) {
        try {
            boolean userExists = userService.userByIdExists(id);
            return ResponseEntity.ok(userExists);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping("/sign_in")
    public ResponseEntity<User> getUser(@RequestBody User user) {
        try {
            return ResponseEntity.ok(userService.getUser(user));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/get_user_by_id")
    public ResponseEntity<User> getUserById(@RequestParam String id) {
        try {
            User user = userService.getUserById(id);
            return ResponseEntity.ok(user);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }
}