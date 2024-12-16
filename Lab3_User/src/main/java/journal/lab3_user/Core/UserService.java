package journal.lab3_user.Core;

import journal.lab3_user.Core.Model.User;
import journal.lab3_user.Persistence.IUserRepository;
import journal.lab3_user.Persistence.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    IUserRepository userRepository;

    public void createUser(User user) {
        UserEntity userEntity = user.getEntity();
        userRepository.save(userEntity);
    }

    public User getUser(User user) {
        List<UserEntity> userEntities = userRepository.findUserByIdPassword(user.getId(), user.getPassword());
        if (userEntities.isEmpty()) {
            return null;
        }
        return new User(userEntities.get(0));
    }

    public boolean userByIdExists(String id) {
        User user = getUserById(id);
        return user != null;
    }

    public User getUserById(String id) {
        List<UserEntity> userEntities = userRepository.findUserById(id);
        if (userEntities.isEmpty()) {
            return null;
        }
        return new User(userEntities.get(0));
    }
}