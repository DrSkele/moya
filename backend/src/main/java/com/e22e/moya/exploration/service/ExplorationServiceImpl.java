package com.e22e.moya.exploration.service;

import com.e22e.moya.common.entity.Exploration;
import com.e22e.moya.common.entity.npc.Npc;
import com.e22e.moya.common.entity.npc.NpcPos;
import com.e22e.moya.common.entity.npc.ParkNpcs;
import com.e22e.moya.common.entity.park.Park;
import com.e22e.moya.common.entity.species.ParkSpecies;
import com.e22e.moya.common.entity.species.Species;
import com.e22e.moya.common.entity.species.SpeciesPos;
import com.e22e.moya.exploration.dto.initInfo.ExplorationStartDto;
import com.e22e.moya.exploration.dto.initInfo.NpcDto;
import com.e22e.moya.exploration.dto.initInfo.PositionDto;
import com.e22e.moya.exploration.dto.initInfo.SpeciesDto;
import com.e22e.moya.exploration.repository.ExplorationRepository;
import com.e22e.moya.exploration.repository.ParkRepository;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Point;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
public class ExplorationServiceImpl implements ExplorationService {

    private final ParkRepository parkRepository;
    private final QuestService questService;
    private final ExplorationRepository explorationRepository;

    public ExplorationServiceImpl(ParkRepository parkRepository, QuestService questService,
        ExplorationRepository explorationRepository) {
        this.parkRepository = parkRepository;
        this.questService = questService;
        this.explorationRepository = explorationRepository;
    }

    /**
     * 초기 탐험 정보 가져오는 메서드
     *
     * @param parkId 공원 id
     * @param userId 사용자 id
     *
     */
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public ExplorationStartDto getInitInfo(Long parkId, Long userId) {
        ExplorationStartDto explorationStartDto = new ExplorationStartDto();

        Park park = parkRepository.findById(parkId)
            .orElseThrow(() -> new RuntimeException("공원을 찾을 수 없음"));

        List<SpeciesDto> speciesDtos = getSpeciesInPark(park);
        List<NpcDto> npcDtos = getNpcsInPark(park);

        explorationStartDto.setSpecies(speciesDtos);
        explorationStartDto.setNpcs(npcDtos);

        // 새로운 탐험 생성 및 저장
        Exploration exploration = new Exploration();
        exploration.setPark(park);
        exploration.setUserId(userId);
        exploration.setStartDate(LocalDate.now());
        exploration.setStartTime(LocalDateTime.now());
        exploration = explorationRepository.save(exploration);

        log.info(" {} 종의 동식물 발견. 공원 id: {}", speciesDtos.size(), parkId);
        for (SpeciesDto species : speciesDtos) {
            log.info("종: {}, 위치: {}", species.getName(), species.getPositions().size());
        }

        questService.generateNewQuests(exploration);

        return explorationStartDto;
    }

    /**
     * 공원에 있는 동식물 가져오는 메서드
     *
     * @param park 공원 엔티티
     *
     */
    private List<SpeciesDto> getSpeciesInPark(Park park) {
        List<SpeciesDto> speciesDtoList = new ArrayList<>();
        for (ParkSpecies parkSpecies : park.getParkSpecies()) {
            speciesDtoList.add(convertToSpeciesDto(parkSpecies));
        }
        return speciesDtoList;
    }

    /**
     * 공원에 있는 npc 가져오는 메서드
     *
     * @param park 공원 엔티티
     *
     */
    private List<NpcDto> getNpcsInPark(Park park) {
        List<NpcDto> npcDtoList = new ArrayList<>();
        for (ParkNpcs parkNpc : park.getParkNpcs()) {
            npcDtoList.add(convertToNpcDto(parkNpc));
        }
        return npcDtoList;
    }

    /**
     * ParkSpecies 엔티티를 dto로 변환하는 메서드
     *
     * @param parkSpecies 엔티티
     *
     */
    private SpeciesDto convertToSpeciesDto(ParkSpecies parkSpecies) {
        Species species = parkSpecies.getSpecies();
        SpeciesDto speciesDto = new SpeciesDto();
        speciesDto.setId(species.getId());
        speciesDto.setName(species.getName());
        speciesDto.setScientificName(species.getScientific_name());
        speciesDto.setDescription(species.getDescription());
        speciesDto.setImageUrl(species.getImageUrl());
        speciesDto.setPositions(convertToPositionDtos(parkSpecies.getPositions()));
        return speciesDto;
    }

    /**
     * ParkNpcs 엔티티를 dto로 변환하는 메서드
     *
     * @param parkNpc 엔티티
     *
     */
    private NpcDto convertToNpcDto(ParkNpcs parkNpc) {
        Npc npc = parkNpc.getNpc();
        NpcDto npcDto = new NpcDto();
        npcDto.setId(npc.getId());
        npcDto.setName(npc.getName());
        npcDto.setPositions(convertToPositionDtos(parkNpc.getPositions()));
        return npcDto;
    }

    /**
     * 좌표들을 PositionDto로 변환하는 메서드
     *
     * @param positions 좌표들
     *
     */
    private List<PositionDto> convertToPositionDtos(List<?> positions) {
        List<PositionDto> positionDtoList = new ArrayList<>();
        for (Object pos : positions) {
            PositionDto positionDto = new PositionDto();
            Point point = null;
            if (pos instanceof SpeciesPos) {
                point = ((SpeciesPos) pos).getPos();
            } else if (pos instanceof NpcPos) {
                point = ((NpcPos) pos).getPos();
            }
            if (point != null) {
                positionDto.setLatitude(point.getY());  // PostGIS에서 Y가 위도
                positionDto.setLongitude(point.getX()); // PostGIS에서 X가 경도
            }
            positionDtoList.add(positionDto);
        }
        return positionDtoList;
    }

}