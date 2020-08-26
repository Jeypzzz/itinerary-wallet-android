class Validators{
  Function(String) loginUsernameValidator = (String username) {
    if (username.isEmpty) {
      return 'Please enter some name';
    }else if (username.length < 3) {
      return 'Username must be atleast 3 characters';
    }
    return null;
  };
  Function(String) loginPasswordValidator = (String password) {
    if (password.isEmpty) {
      return 'Please enter some name';
    }else if (password.length < 3) {
      return 'Username must be atleast 3 characters';
    }
    return null;
  };
  Function(String) forgotPasswordEmailValidator = (String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return '*Enter valid email address';
    }
    return null;
  };

  Function(String) changePasswordEmailValidator = (String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return '*Enter valid email address';
    }
    return null;
  };

  changePasswordCurrentValidator(password){
    if (password.isEmpty) {
      return 'Please enter some name';
    }else if (password.length < 3) {
      return 'Username must be atleast 3 characters';
    }
    return null;
  }
  
}