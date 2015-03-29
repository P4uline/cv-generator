package com.cvgenerator.service;

import static com.cvgenerator.exception.CvGeneratorException.Type.NOT_FOUND;
import static java.util.Collections.emptyList;

import java.util.List;
import java.util.stream.Collectors;

import com.cvgenerator.dao.CvDao;
import com.cvgenerator.entity.Cv;
import com.cvgenerator.entity.Skill;
import com.cvgenerator.exception.CvGeneratorException;
import com.google.inject.Inject;

public class CvService {
	
	private CvDao cvDao;
	
	@Inject
	public CvService(CvDao cvDao) {
		this.cvDao = cvDao;
	}
	
	public List<String> findCompanies(String firstName, String lastName) {
		
		// Get curriculum vitea.
		Cv cv = cvDao.findOne(firstName, lastName);
		if (cv == null) {
			throw new CvGeneratorException(NOT_FOUND, "The cv of '" + firstName + " " +lastName +"' is not found in database.");
		}

		// If cv has no experience, returns empty list.
		if (cv.getExperiences() == null) {
			return emptyList();
		}

		// Get the actual company where the person belong from the cv.
		return cv.getExperiences().stream().
				filter(e -> e.getCompany() != null).
				map(e -> e.getCompany().getName()).
				collect(Collectors.toList());
	}
	
	public List<Skill> sortSkillsByLevel(String firstName, String lastName) {
		// TODO
		return null;
	}
	
}
