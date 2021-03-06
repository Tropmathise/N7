package monopoly.divers;

public class ImpayableException extends Exception {

	private static final long serialVersionUID = 1L;

	public ImpayableException() {
		super();
	}

	public ImpayableException(String message) {
		super(message);

	}

	public ImpayableException(Throwable cause) {
		super(cause);
	}

	public ImpayableException(String message, Throwable cause) {
		super(message, cause);
	}

	public ImpayableException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
