package Drawables;

import Enums.ILanguageObjectType;
import Interfaces.IDrawable;
import Interfaces.ILanguageObject;

import java.awt.*;
import java.awt.geom.Ellipse2D;

/**
 * Created with IntelliJ IDEA.
 * User: emil
 * Date: 12/5/13
 * Time: 9:04 AM
 * To change this template use File | Settings | File Templates.
 */
public class MarkerObjectDrawable implements IDrawable {

    private ILanguageObject markerToDraw;

    private Color markerColor;
    private Point position;
    private int radius;

    public MarkerObjectDrawable(ILanguageObject markerToDraw, Point position, int radius)
    {
        this.markerToDraw = markerToDraw;
        this.radius = radius;
        this.position = position;

        this.markerColor = markerToDraw.getType() == ILanguageObjectType.Startmarker ? new Color(123,123,123) : markerToDraw.getType() == ILanguageObjectType.Endmarker ? new Color(123,123,123) : new Color(255,255,255);
    }

    public void Draw(Graphics g)
    {
        Ellipse2D.Double circle = new Ellipse2D.Double(this.position.x, this.position.y, 50,50);

        g.setColor(this.markerColor);
        ((Graphics2D)g).fill(circle);
        g.setColor(Color.black);
        ((Graphics2D)g).draw(circle);

        g.drawString(this.markerToDraw.getType().toString(), this.position.x + 10, this.position.y + 31);
    }

    @Override
    public void calculateDrawingSize() {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public Point getPosition() {
        return this.position;
    }

    @Override
    public int getWidth() {
        return this.radius;
    }

    @Override
    public int getHeight() {
        return this.radius;
    }

    @Override
    public void setPosition(Point p) {
        this.position = p;
    }

    @Override
    public boolean isPointInside(Point mousePosition)
    {
        return (mousePosition.x > this.position.x && mousePosition.x < this.position.x + this.radius &&
                mousePosition.y > this.position.y && mousePosition.y < this.position.y + this.radius);
    }
}
