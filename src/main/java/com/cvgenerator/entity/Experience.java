package com.cvgenerator.entity;

import java.util.Date;
import java.util.List;

public class Experience {
	
	private Date begin;
	
	private Date end;
	
	private Company company;
	
	private List<String> techno;
	
	private String title;
	
	private String experiencePresentation;
	
	private String rolePresentation;

	public Date getBegin() {
		return begin;
	}

	public void setBegin(Date begin) {
		this.begin = begin;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public List<String> getTechno() {
		return techno;
	}

	public void setTechno(List<String> techno) {
		this.techno = techno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getExperiencePresentation() {
		return experiencePresentation;
	}

	public void setExperiencePresentation(String experiencePresentation) {
		this.experiencePresentation = experiencePresentation;
	}

	public String getRolePresentation() {
		return rolePresentation;
	}

	public void setRolePresentation(String rolePresentation) {
		this.rolePresentation = rolePresentation;
	}

}
