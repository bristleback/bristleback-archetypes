#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import pl.bristleback.server.bristle.api.action.DefaultAction;
import pl.bristleback.server.bristle.api.annotations.Action;
import pl.bristleback.server.bristle.api.annotations.ActionClass;
import pl.bristleback.server.bristle.engine.user.BaseUserContext;
import pl.bristleback.server.bristle.serialization.system.annotation.Bind;

@ActionClass(name = "HelloWorld")
@Controller
public class HelloWorldAction implements DefaultAction<BaseUserContext, String> {

  @Autowired
  private SampleClientAction sampleClientAction;

  @Action
  public String executeDefault(BaseUserContext defaultUser, @Bind(required = true) String text) {
    return new StringBuilder(text).reverse().toString();
  }

  @Action
  public String duplicateText(@Bind(required = true) String text) {
    return text + text;
  }

  @Action
  public void sayHelloToAll() {
    sampleClientAction.sayHello("Hello everyone!");
  }
}
