package com.cvgenerator.exception;


public class CvGeneratorException extends IllegalStateException {

	public CvGeneratorException(Type notFound, String string) {
	}

	private static final long serialVersionUID = 1L;
	
	public enum Type { NOT_FOUND }

}
