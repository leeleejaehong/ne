package com.example.neoheulge.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.example.neoheulge.dto.MemberDTO;
import com.example.neoheulge.dto.NeSavProdDTO;

@Service
public class AdminService {

    @Autowired
    private AdminDAO admindao;
    @Autowired
    private SqlSession sqlsession;

    // 캐시 이름을 'members'로 지정하고, 캐시 키를 자동 생성
    @Cacheable(value = "members", key = "'allMembers::' + #offset + ':' + #size")
    public List<MemberDTO> MemberAll(int offset, int size) {
       
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("size", size);
        List<MemberDTO> members = admindao.memberAll(params);
        System.out.println("Fetched members: " + members.size());
        return admindao.memberAll(params);
        
    }

    @Cacheable(value = "members", key = "'search::' + #searchType + ':' + #searchKeyword + ':' + #offset + ':' + #size")
    public List<MemberDTO> searchMember(String searchType, String searchKeyword, int offset, int size) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        params.put("offset", offset);
        params.put("size", size);
        return admindao.searchMember(params);
    }

    // 총 데이터 개수 반환
    public int getTotalCount(String searchType, String searchKeyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        return admindao.getTotalCount(params);
    }
    
    public MemberDTO findMemberById(String memberID) {
    	MemberDTO mdto = admindao.findMember(memberID);
     //System.out.println("memberDATE:"+mdto.getSignup_date());
    	return admindao.findMember(memberID);
    }
    
    @CacheEvict(value = "members", allEntries = true) // 모든 엔트리 무효화
    public int updateMember(MemberDTO dto) {
    	int res = admindao.updateMember(dto);
    	return res;
    }
    @CacheEvict(value = "products", allEntries = true)
    public int addProd(NeSavProdDTO dto) {
    	int res= admindao.addProd(dto);
    	return res;
    }
    @Cacheable("products")
    public List<NeSavProdDTO> prodList(){
    	return admindao.prodList();
    }
    @Cacheable(value = "products", key = "#product_code")
    public NeSavProdDTO prodInfo(String product_code) {
    	return admindao.prodInfo(product_code);
    }
    @CacheEvict(value = "products", allEntries = true)
    public int updateProd(NeSavProdDTO dto) {
    	int res = admindao.updateProd(dto);
    	return res;
    }
    @CacheEvict(value = "products", allEntries = true)
    public int deleteProd(String product_code) {
    	return admindao.deleteProd(product_code);
    }
   public void deleteExpired() {
	    admindao.deleteExpried();
   }
   public List<NeSavProdDTO> chartList(String product_code){
	   return admindao.chartList(product_code);
   }
}
