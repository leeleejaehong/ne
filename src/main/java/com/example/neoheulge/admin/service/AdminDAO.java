package com.example.neoheulge.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.neoheulge.dto.MemberDTO;
@Mapper
public interface AdminDAO {

    List<MemberDTO> memberAll(Map<String, Object> params);
    List<MemberDTO> searchMember(Map<String, Object> params);
    int getTotalCount(Map<String, Object> params);
    int getTotalMemberCount();
    MemberDTO findMember(String memberID);
    int updateMember(MemberDTO dto);
    }
