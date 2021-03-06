package org.harrison.insight.plugin.mongodb;

import java.util.ArrayList;
import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;

import com.mongodb.DBCursor;
import com.springsource.insight.collection.AbstractOperationCollectionAspect;
import com.springsource.insight.intercept.operation.Operation;

public aspect MongoCursorOperationCollectionAspect extends
	AbstractOperationCollectionAspect {
    private static final String UNKNOWN = "?unknown?";
    private static final List<String> EMPTY_ARGS = new ArrayList<String>();

    private pointcut nextExecution(): 
	execution(* DBCursor.next(..));

    private pointcut skipExecution(): 
	execution(* DBCursor.skip(..));

    private pointcut limitExecution(): 
	execution(* DBCursor.limit(..));

    private pointcut toArrayExecution(): 
	execution(* DBCursor.toArray(..));

    private pointcut sortExecution(): 
	execution(* DBCursor.sort(..));

    private pointcut batchSizeExecution(): 
	execution(* DBCursor.batchSize(..));

    public pointcut collectionPoint(): 
	(nextExecution() && !cflowbelow(nextExecution())) ||
	(skipExecution() && !cflowbelow(skipExecution())) ||
	(limitExecution() && !cflowbelow(limitExecution())) ||
	(toArrayExecution() && !cflowbelow(toArrayExecution())) ||
	(sortExecution() && !cflowbelow(sortExecution())) ||
	(batchSizeExecution() && !cflowbelow(batchSizeExecution()));

    @Override
    protected Operation createOperation(final JoinPoint joinPoint) {
	final Signature signature = joinPoint.getSignature();
	final DBCursor cursor = (DBCursor) joinPoint.getTarget();

	if (cursor == null) {
	    return new MongoCursorOperation(getSourceCodeLocation(joinPoint),
		    signature.getName(), EMPTY_ARGS, UNKNOWN, UNKNOWN, UNKNOWN);
	}

	final String collectionName = MongoUtils.extractCollectionName(cursor);

	return new MongoCursorOperation(getSourceCodeLocation(joinPoint),
		signature.getName(), ArgUtils.toString(joinPoint.getArgs()),
		ArgUtils.toString(cursor.getKeysWanted()),
		ArgUtils.toString(cursor.getQuery()), collectionName);
    }

    }
