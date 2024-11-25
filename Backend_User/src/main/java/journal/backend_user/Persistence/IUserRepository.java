package journal.backend_user.Persistence;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IUserRepository extends JpaRepository<UserEntity, String> {

    @Query("SELECT user FROM UserEntity user WHERE user.id = :id AND user.password = :password")
    List<UserEntity> findUserByIdPassword(@Param("id") String id, @Param("password") String password);

    List<UserEntity> findUserById(@Param("id") String id);
}