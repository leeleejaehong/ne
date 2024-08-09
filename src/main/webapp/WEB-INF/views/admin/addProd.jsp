<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
상품추가
<div align="center">

<form name="f" action="/admin/addProdPro.do" method="POST" enctype="multipart/form-data">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" name="product_status" value="활성">
<table>
	<tr>
		<td><label for="product_name">Product_Name :</label>
			<input type="text" name="product_name" id ="product_name"></td>
	</tr>
	<tr>
		<td><label for="prodcut_image">Prodcut_Image : </label>
          <input type="file" name="file" id="prodcut_image" /></td>
    </tr>
	
	<tr>
		<td><label for="base_rate">Base_Rate(기본 금리) :</label>
			<input type="text" name="base_rate" id = "base_rate" placeholder="소수점 두자리까지 입력가능합니다."></td>
	</tr>
	<tr>
		<td><label for="goldenball_rate">Goldenball_Rate(골든볼 금리) :</label>
			<input type="text" name="goldenball_rate" id = "goldenball_rate" placeholder="소수점 두자리까지 입력가능합니다."></td>
	</tr>
	<tr>
		<td><label for="subscription_method">subscription_method(정기결제 방법) : </label>
			<select name="subscription_method">
		<option value="매일">매일</option>
		<option value="매주">매주</option>
		<option value="매달">매달</option>
	</select></td>
	</tr>
	<tr>
		<td><label for="subscription_period">subscription_period(가입기간) : </label>
			<select name="subscription_period">
		<option value="1개월">1개월</option>
		<option value="3개월">3개월</option>
		<option value="6개월">6개월</option>
		<option value="1년">1년</option>
	</select></td>
	</tr>
    <!-- <tr>
    	<td><label for ="accumulated_amount">Accumulated_Amount(누적금액) :</label>     
    		<input type="text" name="accumulated_amount" id="accumulated_amount"></td>
    </tr>    --> 
	<tr>
		<td><label for = "termination_conditions">Termination_Conditions(해지조건) :</label>
		<textarea name="termination_conditions" id="termination_conditions" placeholder="상품 해지조건"></textarea>
		
	</tr>
	<tr>
		<td><label for="early_fee">early_fee(중도포기 수수료) : </label>
		<input type="text" name="early_fee" id="early_fee" placeholder="소수점 두자리까지 입력가능합니다."></td>
	</tr>
	<tr>
	<td>
		<label for ="minimum_deposit">minimum_deposit(최소금액) :</label>
		<input type="text" name="minimum_deposit" id="minimum_deposit" placeholder="소수점 두자리까지 입력가능합니다."></td>
	</tr>
	<td>
		<label for ="maximum_deposit">maximum_deposit (최대금액) :</label>
		<input type="text" name="maximum_deposit " id="maximum_deposit " placeholder="소수점 두자리까지 입력가능합니다."></td>
	</tr>
	<tr>
	<td><label for="start_date">start_date(상품 시작일):</label>
    <input type="date" id="start_date" name="start_date"></td>
	</tr>
	<tr>
		<td><label for = "product_description">product_description(상품설명) :</label>
		<textarea name="product_description" id="product_description" placeholder="상품 설명"></textarea>
		
	</tr>
	<tr>
		<td align="center"><input type="submit" value="UPDATE"></td>
	</tr>
</table>
</form>
</div>

<jsp:include page="../footer.jsp"/>