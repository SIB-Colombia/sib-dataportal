package model;

import java.math.BigDecimal;
import java.util.Vector;

public class Conversor {

	public static Vector<Double> calculo(double latitude, double longitude) {
		Vector<Double> coordenadas = new Vector<Double>();
		BigDecimal a = new BigDecimal("6378388.0");
		BigDecimal b = new BigDecimal("6356911.946130");

		BigDecimal e1 = a.pow(2);
		BigDecimal e2 = b.pow(2);
		BigDecimal e3 = e1.subtract(e2);

		double excentricidad2 = Math.sqrt(e3.doubleValue()) / b.doubleValue();
		double exp = Math.pow(excentricidad2, 2);
		double c = Math.pow(a.doubleValue(), 2) / b.doubleValue();

		int huson = (int) Math.floor((longitude / 6) + 31);
		int meridianohuson = huson * 6 - 183;

		double loradianes = longitude * Math.PI / 180;
		double lambda = loradianes - ((meridianohuson * Math.PI) / 180);

		double laradianes = latitude * Math.PI / 180;
		double A = Math.cos(laradianes) * Math.sin(lambda);

		BigDecimal e6 = new BigDecimal(A);
		BigDecimal uno = new BigDecimal("1");
		BigDecimal e7 = uno.subtract(e6);
		BigDecimal e8 = uno.add(e6);
		double aux = e8.doubleValue() / e7.doubleValue();
		double xi = 0.5 * Math.log(aux);

		double ni = (c
				/ (1 + exp * Math.pow(Math.pow(Math.cos(laradianes), 2), 0.5)) * 0.9996);
		double zeta = (exp / 2) * Math.pow(xi, 2)
				* Math.pow(Math.cos(laradianes), 2);
		double eta = Math.atan(Math.tan(laradianes) / Math.cos(lambda))
				- laradianes;
		double a1 = Math.sin(2 * laradianes);
		double a2 = a1 * Math.pow(Math.cos(laradianes), 2);
		double j2 = laradianes + (a1 / 2);
		double j4 = ((3 * j2) + a2) / 4;
		double j6 = (5 * j4 + a2 * Math.pow(Math.cos(laradianes), 2)) / 3;
		double alfa = (0.75) * exp;
		double beta = (1.6666666) * Math.pow(alfa, 2);
		double gamma = (1.2962962) * Math.pow(alfa, 3);
		double bfi = 0.9996 * c
				* (laradianes - (alfa * j2) + (beta * j4) - (gamma * j6));
		coordenadas.add(xi * ni * (1 + zeta / 3) + 500000);

		if (latitude < 0) {
			coordenadas.add(eta * ni * (1 + zeta) + bfi + 10000000);
		} else {
			coordenadas.add(eta * ni * (1 + zeta) + bfi);
		}
		return coordenadas;
	}
}
