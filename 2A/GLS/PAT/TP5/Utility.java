import java.lang.annotation.*;

/** Indicate that a class is a utility class and thus only defines
  * static methods Utility.
  */
@Documented
@Target (ElementType.TYPE)
public @interface Utility {
}
