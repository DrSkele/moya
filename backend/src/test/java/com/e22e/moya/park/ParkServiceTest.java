package com.e22e.moya.park;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.e22e.moya.park.dto.ParkListResponseDto;
import com.e22e.moya.park.dto.ParkResponseDto;
import com.e22e.moya.park.repository.ParkDistanceProjection;
import com.e22e.moya.park.repository.ParkRepositoryPark;
import com.e22e.moya.park.service.ParkServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

class ParkServiceTest {

    @InjectMocks
    private ParkServiceImpl parkService;  // ParkServiceImpl을 사용해야 함

    @Mock
    private ParkRepositoryPark parkRepositoryPark;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetParks() {
        // Given
        long userId = 1L;
        double latitude = 36.107000;
        double longitude = 128.416000;
        int page = 0;
        int size = 10;

        System.out.println("Given 단계 - 공원 데이터 준비");

        // Projection 인터페이스를 사용하여 mock 데이터를 설정
        ParkDistanceProjection park1 = mock(ParkDistanceProjection.class);
        when(park1.getId()).thenReturn(1L);
        when(park1.getName()).thenReturn("싸피 뒷뜰");
        when(park1.getImageUrl()).thenReturn("https://example.com/seoul-forest.jpg");
        when(park1.getDistance()).thenReturn(137.0);

        ParkDistanceProjection park2 = mock(ParkDistanceProjection.class);
        when(park2.getId()).thenReturn(2L);
        when(park2.getName()).thenReturn("동락공원");
        when(park2.getImageUrl()).thenReturn("https://example.com/olympic-park.jpg");
        when(park2.getDistance()).thenReturn(200.0);

        List<ParkDistanceProjection> parks = Arrays.asList(park1, park2);
        when(parkRepositoryPark.findParksWithDistance(latitude, longitude, page, size)).thenReturn(
            parks);

        System.out.println("When 단계 - 공원 목록 가져오기 실행");

        // When
        ParkListResponseDto parkListResponseDto = parkService.getParks(userId, latitude, longitude,
            page, size);

        System.out.println("Then 단계 - 테스트 결과 확인");
        System.out.println("가져온 공원 목록 크기: " + parkListResponseDto.getParks().size());

        // Then
        assertNotNull(parkListResponseDto);
        assertEquals(2, parkListResponseDto.getParks().size());

        ParkResponseDto responsePark1 = parkListResponseDto.getParks().get(0);
        System.out.println("첫 번째 공원 이름: " + responsePark1.getParkName());
        assertEquals(park1.getId(), responsePark1.getParkId());
        assertEquals(park1.getName(), responsePark1.getParkName());

        ParkResponseDto responsePark2 = parkListResponseDto.getParks().get(1);
        System.out.println("두 번째 공원 이름: " + responsePark2.getParkName());
        assertEquals(park2.getId(), responsePark2.getParkId());
        assertEquals(park2.getName(), responsePark2.getParkName());
    }
}
