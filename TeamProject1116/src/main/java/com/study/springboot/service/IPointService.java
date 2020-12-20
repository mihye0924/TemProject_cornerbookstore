package com.study.springboot.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.PointDto;
 
 
public interface IPointService {
	public int insertPoint(HttpServletRequest request);
	public int cancelPoint(HttpServletRequest request);
	public List<PointDto> pointList(String id,Criteria cri);
	public int count(String id);
} 
