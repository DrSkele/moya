package com.e22e.moya.park.service;

import com.e22e.moya.common.entity.park.Park;
import com.e22e.moya.park.dto.ParkDetailResponseDto;
import com.e22e.moya.park.dto.ParkListResponseDto;
import com.e22e.moya.park.dto.ParkResponseDto;
import com.e22e.moya.park.dto.SpeciesDto;
import com.e22e.moya.park.repository.ParkDistanceProjection;
import com.e22e.moya.park.repository.ParkRepositoryPark;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ParkServiceImpl implements ParkService {

    private final ParkRepositoryPark parkRepositoryPark;

    /**
     * PostGIS를 사용하여 가장 가까운 공원을 반환
     *
     * @param userId    사용자 ID
     * @param latitude  사용자 위도
     * @param longitude 사용자 경도
     * @return 가장 가까운 공원 정보
     */
    @Override
    @Transactional(readOnly = true, isolation = Isolation.REPEATABLE_READ)
    public ParkResponseDto getNearestPark(Long userId, double latitude, double longitude) {
        // 가장 가까운 공원 조회
        ParkDistanceProjection nearestPark = parkRepositoryPark.findNearestPark(latitude,
            longitude);

        if (nearestPark == null) {
            throw new IllegalArgumentException("공원을 찾을 수 없습니다.");
        }

        return new ParkResponseDto(
            nearestPark.getId(),
            nearestPark.getName(),
            nearestPark.getDistance().intValue(),
            nearestPark.getImageUrl()
        );
    }

    /**
     * PostGIS로 거리 계산 후 공원 목록 반환
     *
     * @param userId    사용자 ID
     * @param latitude  사용자 위도
     * @param longitude 사용자 경도
     * @param page      페이지 번호
     * @param size      페이지 크기
     * @return 공원 목록 정보
     */
    @Override
    @Transactional(readOnly = true, isolation = Isolation.REPEATABLE_READ)
    public ParkListResponseDto getParks(Long userId, double latitude, double longitude, int page,
        int size) {
        int offset = (page - 1) * size;
        // 공원 목록 조회
        List<ParkDistanceProjection> parks = parkRepositoryPark.findParksWithDistance(latitude,
            longitude, offset, size);

        List<ParkResponseDto> parkDtos = parks.stream()
            .map(park -> new ParkResponseDto(
                park.getId(),
                park.getName(),
                park.getDistance().intValue(),
                park.getImageUrl()
            ))
            .collect(Collectors.toList());

        return new ParkListResponseDto(parkDtos);
    }

    /**
     * 공원의 상세 정보를 반환
     *
     * @param parkId 공원 ID
     * @return 공원의 상세 정보
     */
    @Override
    @Transactional(readOnly = true, isolation = Isolation.REPEATABLE_READ)
    public ParkDetailResponseDto getParkDetail(Long parkId) {
        Park park = parkRepositoryPark.findById(parkId)
            .orElseThrow(() -> new IllegalArgumentException("공원을 찾을 수 없습니다."));

        // 공원에 있는 종 정보 조회 및 SpeciesDto로 변환
        List<SpeciesDto> speciesDtos = park.getParkSpecies().stream()
            .map(parkSpecies -> new SpeciesDto(
                parkSpecies.getSpecies().getId(),
                parkSpecies.getSpecies().getName(),
                parkSpecies.getSpecies().getImageUrl(),
                false))
            .collect(Collectors.toList());

        return new ParkDetailResponseDto(
            park.getId(),
            park.getName(),
            park.getDescription(),
            park.getImageUrl(),
            speciesDtos
        );
    }
}