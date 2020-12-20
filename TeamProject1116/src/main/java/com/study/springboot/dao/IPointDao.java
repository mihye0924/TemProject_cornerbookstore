 
package com.study.springboot.dao;
   
import java.util.HashMap;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.PointDto;


//로그인, 회원가입
@Mapper
public interface IPointDao {
	public int insertPointDao(PointDto dto);  
	public int cancelPointDao(PointDto dto);  
	public List<PointDto> pointListDao(HashMap <String,Object> map);
	public int countDao(String id);
} 