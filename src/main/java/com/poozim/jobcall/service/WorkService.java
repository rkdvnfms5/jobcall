package com.poozim.jobcall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.repository.WorkRepository;

@Service
public class WorkService {

	@Autowired
	private WorkRepository workRepository;
	
	public List<Work> getWorkList() {
		return workRepository.findAll();
	}
	
	public Work getWorkOne(int seq) {
		return workRepository.findById(seq).get();
	}
	
	public Work getWorkByCode(String code) {
		return workRepository.getWorkOneByCode(code);
	}
}
