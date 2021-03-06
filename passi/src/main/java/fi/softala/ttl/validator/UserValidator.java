package fi.softala.ttl.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import fi.softala.ttl.model.User;
import fi.softala.ttl.service.PassiService;

@Component
public class UserValidator implements Validator {

    @Autowired
    private PassiService passiService;
	
	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-+]+(.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(.[A-Za-z0-9]+)*(.[A-Za-z]{2,})$";
	private static final String USERNAME_PATTERN = "^[A-zÄÖäöÅå0-9-._]{0,30}$";
	
    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;
        
        if (passiService.isUsernameExists(user.getUsername())) {
            errors.rejectValue("username", "Duplicate.userForm.username");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "NotEmpty");
        if (user.getUsername().length() < 3 || user.getUsername().length() > 30) {
            errors.rejectValue("username", "Size.userForm.username");
        }
        
        if (!user.getUsername().matches(USERNAME_PATTERN)) {
        	errors.rejectValue("username", "Match.userForm.username");
        }
        
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstname", "NotEmpty");
        if (user.getFirstname().length() < 2 || user.getFirstname().length() > 40) {
            errors.rejectValue("firstname", "Size.userForm.firstname");
        }
        
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastname", "NotEmpty");
        if (user.getLastname().length() < 2 || user.getLastname().length() > 60) {
            errors.rejectValue("lastname", "Size.userForm.lastname");
        }
        
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "NotEmpty");
        if (!user.getEmail().matches(EMAIL_PATTERN)) {
            errors.rejectValue("email", "Match.userForm.email");
        }
        if (passiService.isEmailExists(user.getEmail())) {
            errors.rejectValue("email", "Duplicate.userForm.email");
        }
        
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty");
        if (user.getPassword().length() < 5 || user.getPassword().length() > 128) {
            errors.rejectValue("password", "Size.userForm.password");
        }
        
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPassword", "NotEmpty");
        if (!user.getConfirmPassword().equals(user.getPassword())) {
            errors.rejectValue("confirmPassword", "Diff.userForm.confirmPassword");
        }
    }
}