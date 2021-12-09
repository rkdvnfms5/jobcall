package com.poozim.jobcall.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.mapper.MemberMapper;
import com.poozim.jobcall.mapper.WorkMapper;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkBoardFile;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.repository.CommentRepository;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkBoardRepository;
import com.poozim.jobcall.repository.WorkRepository;
import com.poozim.jobcall.util.LoginUtil;
import com.poozim.jobcall.util.OciUtil;
import com.poozim.jobcall.util.SessionUtil;
import com.poozim.jobcall.util.StringUtil;
import com.poozim.jobcall.util.TimeUtil;

@Service
public class MemberService {

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private WorkBoardRepository workBoardRepository;
	
	@Autowired
	private CommentRepository commentRepository;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private BCryptPasswordEncoder bcryEncoder;
	
	public List<Member> getMemberList(Member member) {
		return memberRepository.getWorkMemberList(member);
	}
	
	public Member getMemberOne(int seq) {
		return memberRepository.findById(seq).get();
	}
	
	public Member getMemberOneCustom(Member member) {
		return memberRepository.getMemberOne(member);
	}
	
	public Member insertMember(Member member) {
		member.setPassword(bcryEncoder.encode(member.getPassword()));
		
		return memberRepository.save(member);
	}
	
	public Member getMemberById(Member member) {
		return memberRepository.getMemberById(member);
	}
	
	public List<Member> getGroupMemberList(WorkGroupMember wgm){
		return memberRepository.getWorkGroupMemberList(wgm);
	}
	
	@Transactional
	public int updateMember(Member member, HttpServletRequest request, HttpServletResponse response) {
		if(member.getProfileImage() != null && !member.getProfileImage().isEmpty()) {
			Work sessionWork = SessionUtil.getWorkInfo(request, response);
			
			//delete origin Profile Image
			if(member.getProfile() != null && !member.getProfile().equals("")) {
				//https://objectstorage.ap-seoul-1.oraclecloud.com/p/44vP_vA-3F4o_jcA3Hj4jsrYg8q--Oh0Pvd8QpH63KcEWcx-JfJ1Cj7O087tqXuL/n/cnwovahmge5s/b/bucket-20210728-1124/o/temp_scene02_20211126131012.png
				String originObjectName = member.getProfile().substring(member.getProfile().lastIndexOf("/") + 1);
				OciUtil.deleteObject(sessionWork.getBucket_name(), originObjectName);
			}
			
			//insert new Profile Image
			String str = member.getProfileImage().getOriginalFilename();
			String objectName =  str.substring(0, str.lastIndexOf(".")) + "_" + TimeUtil.getDateTimeString() + str.substring(str.lastIndexOf("."));
			
			try {
				String bucketName = sessionWork.getBucket_name();//버킷 네임 해야함
				
				if(OciUtil.createObject(bucketName, member.getProfileImage(), objectName) > 0) {
					member.setProfile(OciUtil.getObjectSrc(sessionWork.getPreauth_code(), bucketName, objectName));
				}
				
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
		}
		
		member = memberRepository.save(member);
		
		//Board, Comment 회원 정보 수정
		workBoardRepository.updateMemberProfile(member);
		commentRepository.updateMemberProfile(member);
		
		//회원 세션 수정
		LoginUtil.setLoginSession(request, response, member);
		
		return 1;
	}
	
	public List<Member> getInviteList(WorkGroup workGroup) {
		return memberMapper.getInviteList(workGroup);
	}
	
	public List<Member> getInviteLogList(WorkGroup workGroup) {
		return memberMapper.getInviteLogList(workGroup);
	}
	
}
