import javax.annotation.processing.*;
import javax.lang.model.SourceVersion;
import javax.lang.model.element.*;
import java.util.*;
import javax.tools.Diagnostic.Kind;

/** Check that a class marked {@code @Utility} is indeed a utility class. */
@SupportedAnnotationTypes("Utility")
@SupportedSourceVersion(SourceVersion.RELEASE_11)
public class UtilityProcessor extends AbstractProcessor {

	@Override
	public boolean process(
			Set<? extends TypeElement> annotations,
			RoundEnvironment roundingEnvironment)
	{
		Messager messager = processingEnv.getMessager();
		for (TypeElement te : annotations) {
			for (Element elt : roundingEnvironment.getElementsAnnotatedWith(te)) {
				if (elt.getKind().equals(ElementKind.CLASS)) {
					// Check that the class is declared final
					if(!elt.getModifiers().contains(Modifier.FINAL)){
						messager.printMessage(Kind.ERROR, "la clase doit contenir final");
					}
					// Check that enclosed elements are static
					for(Element enclosedElements : elt.getEnclosedElements()){
						if (!enclosedElements.getModifiers().contains(Modifier.STATIC)){
							if (enclosedElements.getKind().equals(ElementKind.CONSTRUCTOR)){
								ExecutableElement e = (ExecutableElement) enclosedElements;
								if(e.getParameters().size()>0){
									messager.printMessage(Kind.WARNING, "La classe doit avoir un constructeur par default", e);
								}
								if(!e.getModifiers().contains(Modifier.PRIVATE)){
									messager.printMessage(Kind.ERROR,
											"La classe doit etre privée", e);
								}
							} else {
								messager.printMessage(Kind.ERROR, "un element de la classe doit etre static");
							}
							
						}
					}

				} else {
					messager.printMessage(Kind.ERROR,
							"@Utility applies to class only:", elt);
				}
			}
		}
		return true;
	}

}
