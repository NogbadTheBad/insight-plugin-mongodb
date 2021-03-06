package org.harrison.insight.plugin.mongodb;

import java.util.List;

import com.springsource.insight.intercept.operation.BasicOperation;
import com.springsource.insight.intercept.operation.OperationType;
import com.springsource.insight.intercept.operation.SourceCodeLocation;

/**
 * A Spring Insight {@link BasicOperation} that collects MongoDB DB operations
 * 
 * @author stephen harrison
 */
public class MongoDbOperation extends MongoBasicOperation {
    public static final String NAME = "mongo_db_operation";
    public static final OperationType TYPE = OperationType.valueOf(NAME);

    private final List<String> args;

    public MongoDbOperation(final SourceCodeLocation scl,
	    final String method, final List<String> args) {
	super(scl, method, TYPE);

	this.args = args;
    }

    public String getLabel() {
	return "MongoDB: DB." + getMethod() + "()";
    }

    public List<String> getArgs() {
	return args;
    }
}
