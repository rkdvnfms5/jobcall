package com.poozim.jobcall.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.mapper.WorkMapper;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkCategoryGroupRepository;
import com.poozim.jobcall.repository.WorkCategoryRepository;
import com.poozim.jobcall.repository.WorkGroupMemberRepository;
import com.poozim.jobcall.repository.WorkGroupRepository;
import com.poozim.jobcall.repository.WorkRepository;
import com.poozim.jobcall.util.OciUtil;
import com.poozim.jobcall.util.TimeUtil;

@Service
public class SignService {

	@Autowired
	private WorkRepository workRepository;
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private WorkGroupRepository workGroupRepository;
	
	@Autowired
	private WorkGroupMemberRepository workGroupMemberRepository;
	
	@Autowired
	private WorkCategoryRepository workCategoryRepository;
	
	@Autowired
	private WorkCategoryGroupRepository WorkCategoryGroupRepository;
	
	@Autowired
	private BCryptPasswordEncoder bcryEncoder;
	
	@Autowired
	private WorkMapper workMapper;
	
	@Transactional
	public int signupWork(Work work, Member member) {
		member.setPassword(bcryEncoder.encode(member.getPassword()));
		
		//멤버 생성
		member = memberRepository.save(member);
		
		//업무 생성
		work.setMember_seq(member.getSeq());
		work = workRepository.save(work);
		member.setWork_seq(work.getSeq());
		
		//workRepository.setWorkCode(work);
		work.setCode(workMapper.getCreatedWorkCode(work.getTitle()));
		
		//기본 그룹 생성
		WorkGroup workGroup = new WorkGroup();
		workGroup.setMember_seq(member.getSeq());
		workGroup.setWork_seq(work.getSeq());
		workGroup.setName("기본 그룹");
		workGroup.setAccess("public");
		workGroup.setRegister(member.getId());
		workGroup.setRegdate(work.getRegdate());
		workGroup.setUseyn("Y");
		
		workGroup = workGroupRepository.save(workGroup);
		
		//기본 그룹에 참여
		WorkGroupMember workGroupMember = new WorkGroupMember();
		workGroupMember.setGroup_seq(workGroup.getSeq());
		workGroupMember.setMember_seq(member.getSeq());
		workGroupMember.setRegdate(work.getRegdate());
		
		workGroupMember = workGroupMemberRepository.save(workGroupMember);
		
		//기본 카테고리 생성
		WorkCategory workCategory = new WorkCategory();
		workCategory.setWork_seq(work.getSeq());
		workCategory.setMember_seq(member.getSeq());
		workCategory.setTitle("미분류 그룹");
		workCategory.setDefaultyn("Y");
		workCategory.setRegdate(work.getRegdate());
		
		workCategory = workCategoryRepository.save(workCategory);
		
		//기본 카테고리에 기본 그룹 추가
		WorkCategoryGroup wcg = new WorkCategoryGroup();
		wcg.setGroup_seq(workGroup.getSeq());
		wcg.setCategory_seq(workCategory.getSeq());
		wcg.setMember_seq(member.getSeq());
		
		WorkCategoryGroupRepository.save(wcg);
		
		//oci 버킷 생성
		
		String bucketName = work.getSeq() + "_" + TimeUtil.getDateTimeString();
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(LocalDateTime.now().plusYears(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		Date expireDate = new Date(2021, 11, 21);
		System.out.println(expireDate);
		try {
			work.setBucket_name(OciUtil.createBucket(bucketName));
			work.setPreauth_code(OciUtil.createPreAuth(bucketName, expireDate));
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("OCI Error");
		}
		
		return 1;
	}
}
