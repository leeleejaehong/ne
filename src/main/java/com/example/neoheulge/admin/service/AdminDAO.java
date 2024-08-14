package com.example.neoheulge.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.neoheulge.dto.MemberDTO;
import com.example.neoheulge.dto.NeSavProdDTO;
@Mapper
public interface AdminDAO {

    List<MemberDTO> memberAll(Map<String, Object> params);
    List<MemberDTO> searchMember(Map<String, Object> params);
    int getTotalCount(Map<String, Object> params);
    int getTotalMemberCount();
    MemberDTO findMember(String memberID);
    int updateMember(MemberDTO dto);
    int addProd(NeSavProdDTO dto);
    List<NeSavProdDTO> prodList();
    NeSavProdDTO prodInfo(String product_code);
    int updateProd(NeSavProdDTO dto);
    int deleteProd(String product_code);
    public void deleteExpried();
    List<NeSavProdDTO> chartList(String product_code);
    }
