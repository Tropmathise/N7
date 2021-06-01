import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface UnTest {
    boolean enabled() default true;
    Class<? extends Throwable> expected() default NoException.class;
    static class NoException extends Throwable {
		private NoException() {}	// Elle ne sera jamais instanciÃƒÂ©e.
	}
}
