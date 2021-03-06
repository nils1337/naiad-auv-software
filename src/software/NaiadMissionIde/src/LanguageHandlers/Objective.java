package LanguageHandlers;

import Enums.ILanguageObjectType;
import Exceptions.NullReferenceException;
import Exceptions.UnableToPreformActionException;
import Interfaces.ILanguageObject;
import Interfaces.ILanguageVariable;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: emil
 * Date: 11/27/13
 * Time: 7:44 AM
 * To change this template use File | Settings | File Templates.
 */
public class Objective implements ILanguageObject {

    private Path path;
    private String objectiveName;

    private List<ILanguageObject> executionalSteps;
    private List<ILanguageVariable> inputVariables;
    private List<ILanguageVariable> outputVariables;

    public Objective(String name)
    {
        this.objectiveName = name;

        this.executionalSteps = new ArrayList<ILanguageObject>();
        this.inputVariables = new ArrayList<ILanguageVariable>();
        this.outputVariables = new ArrayList<ILanguageVariable>();
    }

    public List<ILanguageObject> getExecutionalSteps() throws NullReferenceException {
        if(this.executionalSteps != null)
            return this.executionalSteps;
        throw new NullReferenceException("this.executionalSteps");
    }

    public void AddExecutionalStep(ILanguageObject object) throws UnableToPreformActionException
    {
        if(!this.executionalSteps.add(object))
            throw new UnableToPreformActionException("Unable to add object to executional steps");
    }

    public void RemoveExecutionalStep(ILanguageObject object) throws UnableToPreformActionException
    {
        if(!this.executionalSteps.remove(object))
            throw new UnableToPreformActionException("Unable to remove object from executional steps");
    }

    @Override
    public Path getFilePath() throws NullReferenceException
    {
        if(this.path != null)
            return this.path;
        throw new NullReferenceException("this.path");
    }

    @Override
    public String toString()
    {
        return "O : " + this.objectiveName;
    }

    @Override
    public List<ILanguageVariable> getInputVariables() {
        return this.inputVariables;
    }

    @Override
    public List<ILanguageVariable> getOutputVariables() {
        return this.outputVariables;
    }

    @Override
    public ILanguageObjectType getType() {
        return ILanguageObjectType.Objective;
    }

    @Override
    public boolean equals(Object other)
    {
        if(!this.toString().equals(other.toString()))
            return false;

        if(this.executionalSteps != ((Objective)other).executionalSteps)
            return false;

        if(this.getClass() != other.getClass())
            return false;


        return this.path != ((Objective)other).path;
    }
}
