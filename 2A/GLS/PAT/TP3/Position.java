/** DÃ©finir une position.  */

import lombok.*;

@Data
public class Position {
	public int x;
	public int y;

	public Position(int x, int y) {
		System.out.println("Position(" + x + ", " + y + ")");
		this.x = x;
		this.y = y;
	}
}
