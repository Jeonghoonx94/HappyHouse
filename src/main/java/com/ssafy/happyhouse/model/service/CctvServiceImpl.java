package com.ssafy.happyhouse.model.service;

import java.io.FileReader;
import java.util.LinkedList;
import java.util.List;

import org.json.simple.parser.JSONParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import com.ssafy.happyhouse.model.CctvDto;

@Service
public class CctvServiceImpl implements CctvService{

	@Override
	public List<CctvDto> list() {
		
		List<CctvDto> list= new LinkedList<>();
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsonObject = (JSONObject) parser.parse(new FileReader( ResourceUtils.getFile("classpath:static/data/cctvdata.json")));
			
			JSONArray fields = (JSONArray) jsonObject.get("fields"); 
			JSONArray records = (JSONArray) jsonObject.get("records");
			
			CctvDto cctv ;
			for(int i=0; i<records.size(); i++) {
				cctv = new CctvDto();
				JSONObject tmp = (JSONObject) records.get(i);
				cctv.setLat((String) tmp.get("위도"));
				cctv.setLon((String) tmp.get("경도"));
				cctv.setRoadName((String) tmp.get("소재지도로명주소"));
				boolean added = false;
				if(cctv.getRoadName() != null && cctv.getRoadName().contains("서울특별시")) {
					list.add(cctv);
					added = true;
				}
				
				cctv.setRoadName((String) tmp.get("소재지지번주소"));
				if(cctv.getRoadName() != null && !added && cctv.getRoadName().contains("서울특별시")) {
					list.add(cctv);
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<CctvDto> search(String name) {
		// TODO Auto-generated method stub
		List<CctvDto> list= new LinkedList<>();
		try {
			System.out.println(name);
			JSONParser parser = new JSONParser();
			JSONObject jsonObject = (JSONObject) parser.parse(new FileReader( ResourceUtils.getFile("classpath:static/data/cctvdata.json")));
			
			JSONArray fields = (JSONArray) jsonObject.get("fields"); 
			JSONArray records = (JSONArray) jsonObject.get("records");
			
			CctvDto cctv ;
			for(int i=0; i<records.size(); i++) {
				cctv = new CctvDto();
				JSONObject tmp = (JSONObject) records.get(i);
				cctv.setLat((String) tmp.get("위도"));
				cctv.setLon((String) tmp.get("경도"));
				
				boolean added = false;
				cctv.setRoadName((String) tmp.get("소재지도로명주소"));
				if(cctv.getRoadName() != null && cctv.getRoadName().contains("서울특별시") && cctv.getRoadName().contains(name)) {
					list.add(cctv);
					added = true;
				}
				
				cctv.setRoadName((String) tmp.get("소재지지번주소"));
				if(cctv.getRoadName() != null && !added && cctv.getRoadName().contains("서울특별시") && cctv.getRoadName().contains(name)) {
					list.add(cctv);
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

}