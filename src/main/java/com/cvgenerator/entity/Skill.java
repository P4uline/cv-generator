package com.cvgenerator.entity;

public class Skill {
	
	public enum LEVEL {beginner, medium, expert};
	
	private String label;
	
	private LEVEL level;

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public LEVEL getLevel() {
		return level;
	}

	public void setLevel(LEVEL level) {
		this.level = level;
	}

}
