package com.idqqtec.nms.dao;

import com.idqqtec.nms.pojo.dto.KeyBufferDto;
import com.idqqtec.nms.pojo.po.Keybuffer;
import com.idqqtec.nms.pojo.po.KeybufferExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface KeybufferMapper {
    int countByExample(KeybufferExample example);

    int deleteByExample(KeybufferExample example);

    int deleteByPrimaryKey(Long id);

    int insert(Keybuffer record);

    int insertSelective(Keybuffer record);

    List<Keybuffer> selectByExample(KeybufferExample example);

    Keybuffer selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") Keybuffer record, @Param("example") KeybufferExample example);

    int updateByExample(@Param("record") Keybuffer record, @Param("example") KeybufferExample example);

    int updateByPrimaryKeySelective(Keybuffer record);

    int updateByPrimaryKey(Keybuffer record);
    List<String> distinctPairTNIP(@Param("TNIP")String TNIP);

    List<KeyBufferDto> distinctTNandPairTN();

}