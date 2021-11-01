package com.poozim.jobcall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.mapper.WorkMapper;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkBoardFileRepository;
import com.poozim.jobcall.repository.WorkBoardRepository;
import com.poozim.jobcall.repository.WorkCategoryGroupRepository;
import com.poozim.jobcall.repository.WorkCategoryRepository;
import com.poozim.jobcall.repository.WorkGroupMemberRepository;
import com.poozim.jobcall.repository.WorkGroupRepository;
import com.poozim.jobcall.repository.WorkRepository;

@Service
public class WorkService {

	//JPA Repositories
	@Autowired
	private WorkRepository workRepository;
	
	@Autowired
	private WorkGroupRepository workGroupRepository;
	
	@Autowired
	private WorkGroupMemberRepository workGroupMemberRepository;
	
	@Autowired
	private WorkCategoryRepository workCategoryRepository;
	
	@Autowired
	private WorkCategoryGroupRepository WorkCategoryGroupRepository;
	
	@Autowired
	private WorkBoardRepository workBoardRepository;
	
	@Autowired
	private WorkBoardFileRepository workBoardFileRepository;
	
	
	//Mybatis Mappers
	@Autowired
	private WorkMapper workMapper;
	
	public Work getWorkOne(int seq) {
		return workRepository.findById(seq).get();
	}
	
	public Work getWorkByCode(String code) {
		return workRepository.getWorkOneByCode(code);
	}
	
	//WorkGroup CRUD and Logics
	public List<WorkGroup> getWorkGroupList(WorkGroup workGroup) {
		return workMapper.getWorkGroupList(workGroup);
	}
	
	public WorkGroup getWorkGroupOne(int seq) {
		return workGroupRepository.findById(seq).get();
	}
	
	@Transactional
	public int insertWorkGroup(WorkGroup workGroup) {
		workGroupRepository.save(workGroup);
		
		//그룹 만든 멤버 그룹에 참여
		WorkGroupMember workGroupMember = new WorkGroupMember();
		workGroupMember.setGroup_seq(workGroup.getSeq());
		workGroupMember.setMember_seq(workGroup.getMember_seq());
		workGroupMember.setRegdate(workGroup.getRegdate());
		
		workGroupMemberRepository.save(workGroupMember);
		
		//디폴트 카테고리에 그룹 추가
		WorkCategory defaultCategory = workCategoryRepository.getDefaultCategory(workGroup.getWork_seq());
		WorkCategoryGroup wcg = new WorkCategoryGroup();
		wcg.setGroup_seq(workGroup.getSeq());
		wcg.setCategory_seq(defaultCategory.getSeq());
		wcg.setMember_seq(workGroup.getMember_seq());
		WorkCategoryGroupRepository.save(wcg);
		
		return 1;
	}
	
	public int updateWorkGroup(WorkGroup workGroup) {
		if(workGroup.getSeq() == 0) {
			return 0;
		}
		workGroupRepository.saveAndFlush(workGroup);
		return 1;
	}
	
	public int deleteWorkGroup(WorkGroup workGroup) {
		int memberCnt = workGroupRepository.getWorkGroupMemberCnt(workGroup);
		if(memberCnt > 1) {
			return 0;
		} 
		if(workGroup.getSeq() == 0) {
			return 0;
		}
		workGroupRepository.delete(workGroup);
		return 1;
	}
	
	public int disableWorkGroup(WorkGroup workGroup) {
		if(workGroup.getSeq() == 0) {
			return 0;
		}
		workGroup.setUseyn("N");
		workGroupRepository.save(workGroup);
		return 1;
	}
	
	public WorkGroupMember getWorkGroupMemberOne(int groupseq, int memberseq) {
		return workGroupRepository.getWorkGroupMemberOne(groupseq, memberseq);
	}
	
	//WorkCategory CRUD and Logics
	public List<WorkCategory> getWorkCategoryList(WorkCategory workCategory){
		return workMapper.getWorkCategoryList(workCategory);
	}
	
	public int insertWorkCategory(WorkCategory workCategory) {
		workCategory.setDefaultyn("N");
		workCategoryRepository.save(workCategory);
		return 1;
	}
	
	public int updateWorkCategory(WorkCategory workCategory) {
		if(workCategory.getSeq() == 0) {
			return 0;
		}
		workCategoryRepository.save(workCategory);
		return 1;
	}
	
	@Transactional
	public int deleteWorkCategory(WorkCategory workCategory) {
		if(workCategory.getSeq() == 0) {
			return 0;
		}
		if(workCategory.getDefaultyn() != null && workCategory.getDefaultyn().equals("Y")) {
			return 0;
		}
		//포함되어있던 그룹들 가져와서 디폴트 카테고리에 넣기
		WorkCategory defaultCategory = workCategoryRepository.getDefaultCategory(workCategory.getWork_seq());
		int res = workCategoryRepository.updateCategoryGroupCategoryseq(workCategory.getSeq(), defaultCategory.getSeq());
		if(res > 0) {
			workCategoryRepository.delete(workCategory);
		}
		return res;
	}
	
	//WorkBoard CRUD and Logics
	public List<WorkBoard> getWorkBoardList(WorkBoard workBoard){
		return workMapper.getWorkBoardList(workBoard);
	}
	
}
