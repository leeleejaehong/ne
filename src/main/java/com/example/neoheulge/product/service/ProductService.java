package com.example.neoheulge.product.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.example.neoheulge.dto.NeSavProdDTO;

@Service
public class ProductService {

    @Autowired
    private SqlSession sqlSession;

    // 상품 등록
    public void insertProduct(Map<String, Object> params) {
        sqlSession.insert("insertProduct", params);
    }

    // 모든 상품 정보 가져오기
    //윤장호 수정 상품정보가져올때 cache처리해서 가져오기
    @Cacheable(value = "products")
    public List<NeSavProdDTO> selectAllProducts() {
        return sqlSession.selectList("selectAllProducts");
    }

    // 특정 상품 코드에 따른 상품 정보 가져오기
    public List<NeSavProdDTO> selectProductByCode(String product_code) {
        return sqlSession.selectList("selectProductByCode", product_code);
    }

    // 전 회차 상금 가져오기
    public List<NeSavProdDTO> selectPreviousRoundPrize(Map<String, Object> params) {
        return sqlSession.selectList("selectPreviousRoundPrize", params);
    }

    // 지난 날짜에 따른 이자 포함 총 금액
    public NeSavProdDTO getTotalAmountWithInterest(Map<String, Object> params) {
        return sqlSession.selectOne("getTotalAmountWithInterest", params);
    }

    // 해지 시 수수료를 누적금액에 투입
    public void updateAccumulatedAmount(Map<String, Object> params) {
        sqlSession.update("updateAccumulatedAmount", params);
    }

    // 상품의 모든 정보 수정 가능
    public void updateProduct(Map<String, Object> params) {
        sqlSession.update("updateProduct", params);
    }

    // 원하는 상품의 금리 수정
    public void updateProductRates(Map<String, Object> params) {
        sqlSession.update("updateProductRates", params);
    }

    // 상품의 상태를 가입 기간에 따라 업데이트
    public void updateProductStatus() {
        sqlSession.update("updateProductStatus");
    }

    // 상품 코드를 통한 상품 삭제
    public void deleteProductByCode(String productCode) {
        sqlSession.delete("deleteProductByCode", productCode);
    }
}